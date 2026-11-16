# HASHIMI MOBILES Warranty Starter

This is a **fresh Flutter starter project**, not a production-ready warranty system. It contains an initial customer UI, sample warranty cards, claim forms, a staff dashboard preview, a Supabase schema draft, and a GitHub Actions APK workflow.

## Included
- Customer home screen
- Warranty list and self-registration form
- Claim submission / tracking UI placeholder
- Customer support page
- Staff admin dashboard preview
- Supabase starter SQL schema
- GitHub Actions Android debug APK workflow

## Important status
The screens are currently a UI scaffold. Database reads/writes, OTP login, real IMEI verification, claim status updates, file uploads, live notifications, full Pashto/Dari localization, and secure admin authorization still need implementation and testing. Sample records are not real warranties or claims.

## Build locally
1. Install Flutter stable and Android SDK.
2. Run `flutter create . --platforms=android --org com.hashimimobiles --project-name hashimi_mobiles`.
3. Run `flutter pub get`.
4. Run `flutter run` or `flutter build apk --debug`.

## Build with GitHub Actions
1. Create a new GitHub repository, e.g. `hashimi-mobiles-warranty`.
2. Upload the contents of this ZIP to the repository root (including hidden `.github` folder).
3. Commit to the `main` branch.
4. Open **Actions** → **Build HASHIMI MOBILES Android APK** → **Run workflow**.
5. Download the `HASHIMI-MOBILES-debug-APK` artifact from the completed workflow.

## Supabase setup
1. Create a new Supabase project.
2. Open SQL Editor and review `supabase/schema.sql`.
3. Apply the schema only after confirming the policies meet your requirements.
4. Copy the Project URL and anon/public key into GitHub Actions secrets or pass them at build time:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
5. Never put the Supabase `service_role` key in the Android app or GitHub client build.

Example build command:
```bash
flutter build apk --debug \
  --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_PUBLIC_ANON_KEY
```

## Before real customer use
- Add verified owner/staff authentication and role-based database policies.
- Ensure customers can see only their own records.
- Staff must match IMEI(s) to an actual invoice before activating warranty.
- Define warranty rules separately by brand, distributor, product, and purchase date.
- Add audit logs for every status and warranty change.
- Use private storage buckets for claim images and signed URLs.
- Add OTP login, rate limits, backups, privacy notice, and retention rules.
- Test all screens and policies with separate customer, service-staff, manager, and owner accounts.

## Business details used in the UI
HASHIMI MOBILES, Mia Aslam Plaza, Jalalabad, Nangarhar, Afghanistan
Phone: 0777799150
