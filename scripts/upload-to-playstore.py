#!/usr/bin/env python3
"""
Google Play Store Internal Testing Upload Script
Uploads APK to Google Play Store Internal Testing track
"""

import argparse
import json
import os
import sys
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaFileUpload
import time

class PlayStoreUploader:
    def __init__(self, service_account_file):
        """Initialize the Play Store uploader with service account credentials."""
        self.service_account_file = service_account_file
        self.service = None
        self._authenticate()
    
    def _authenticate(self):
        """Authenticate with Google Play Console API."""
        try:
            credentials = service_account.Credentials.from_service_account_file(
                self.service_account_file,
                scopes=['https://www.googleapis.com/auth/androidpublisher']
            )
            self.service = build('androidpublisher', 'v3', credentials=credentials)
            print("✅ Successfully authenticated with Google Play Console API")
        except Exception as e:
            print(f"❌ Authentication failed: {e}")
            sys.exit(1)
    
    def upload_apk(self, package_name, apk_path, track='internal', release_notes=None):
        """Upload APK to Google Play Store."""
        try:
            print(f"📱 Uploading APK to Google Play Store...")
            print(f"   Package: {package_name}")
            print(f"   Track: {track}")
            print(f"   APK: {apk_path}")
            
            # Check if APK file exists
            if not os.path.exists(apk_path):
                print(f"❌ APK file not found: {apk_path}")
                return False
            
            # Upload the APK
            media = MediaFileUpload(apk_path, mimetype='application/vnd.android.package-archive')
            
            edit_request = self.service.edits().insert(body={}, packageName=package_name)
            edit_result = edit_request.execute()
            edit_id = edit_result['id']
            
            print(f"📝 Created edit: {edit_id}")
            
            # Upload APK to edit
            apk_response = self.service.edits().apks().upload(
                editId=edit_id,
                packageName=package_name,
                media_body=media
            ).execute()
            
            apk_version_code = apk_response['versionCode']
            print(f"📦 APK uploaded successfully. Version code: {apk_version_code}")
            
            # Create release
            release = {
                'versionCodes': [apk_version_code],
                'status': 'completed',
                'releaseNotes': [
                    {
                        'language': 'en-US',
                        'text': release_notes or 'New GenZSpace update with bug fixes and improvements'
                    }
                ]
            }
            
            # Upload release to track
            track_response = self.service.edits().tracks().update(
                editId=edit_id,
                track=track,
                packageName=package_name,
                body={'releases': [release]}
            ).execute()
            
            print(f"🎯 Release uploaded to {track} track")
            
            # Commit the edit
            commit_request = self.service.edits().commit(
                editId=edit_id,
                packageName=package_name
            ).execute()
            
            print("✅ Edit committed successfully")
            print(f"🚀 APK successfully uploaded to Google Play Store {track} track!")
            
            return True
            
        except HttpError as e:
            print(f"❌ HTTP Error: {e}")
            if e.resp.status == 403:
                print("💡 Make sure your service account has the necessary permissions:")
                print("   - Release Manager role or higher")
                print("   - Access to the Internal Testing track")
            return False
        except Exception as e:
            print(f"❌ Upload failed: {e}")
            return False
    
    def get_app_info(self, package_name):
        """Get app information from Google Play Console."""
        try:
            app_info = self.service.edits().get(packageName=package_name).execute()
            print(f"📱 App Info for {package_name}:")
            print(f"   ID: {app_info.get('id', 'N/A')}")
            print(f"   Expiry Time: {app_info.get('expiryTimeSeconds', 'N/A')}")
            return app_info
        except Exception as e:
            print(f"❌ Failed to get app info: {e}")
            return None

def main():
    parser = argparse.ArgumentParser(description='Upload APK to Google Play Store Internal Testing')
    parser.add_argument('--package-name', required=True, help='Package name of the app')
    parser.add_argument('--apk-path', required=True, help='Path to the APK file')
    parser.add_argument('--track', default='internal', choices=['internal', 'alpha', 'beta', 'production'],
                       help='Release track (default: internal)')
    parser.add_argument('--service-account', default='google-play-service-account.json',
                       help='Path to service account JSON file')
    parser.add_argument('--release-notes', help='Release notes for the update')
    
    args = parser.parse_args()
    
    print("🚀 GenZSpace Google Play Store Upload Script")
    print("=" * 50)
    
    # Check if service account file exists
    if not os.path.exists(args.service_account):
        print(f"❌ Service account file not found: {args.service_account}")
        print("💡 Make sure you have set up the Google Play Console API service account")
        sys.exit(1)
    
    # Initialize uploader
    uploader = PlayStoreUploader(args.service_account)
    
    # Upload APK
    success = uploader.upload_apk(
        package_name=args.package_name,
        apk_path=args.apk_path,
        track=args.track,
        release_notes=args.release_notes
    )
    
    if success:
        print("\n🎉 Upload completed successfully!")
        print(f"📱 Your app is now available in the {args.track} track")
        print("🔗 Check your Google Play Console to review the release")
        sys.exit(0)
    else:
        print("\n❌ Upload failed!")
        print("🔍 Check the error messages above for details")
        sys.exit(1)

if __name__ == "__main__":
    main()
