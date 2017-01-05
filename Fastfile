platform :ios do
  lane :before_integration do
    # fetch the number of commits in the current branch
    build_number = 1

    # Set number of commits as the build number in the project's plist file before the bot actually start building the project.
    # This way, the generated archive will have an auto-incremented build number.
    set_info_plist_value(
      path: './MrPutt/Info.plist',
      key: 'CFBundleVersion',
      value: "#{build_number}"
    )

    # Run `pod install`
    cocoapods

    # Download provisioning profiles for the app and copy them to the correct folder.
    sigh(output_path: '/Library/Developer/XcodeServer/ProvisioningProfiles', skip_install: true)
  end

  lane :after_integration do
    plistFile = './MrPutt/Info.plist'

    # ...

    ipa_folder = "#{ENV['XCS_DERIVED_DATA_DIR']}/deploy/#{version_number}.#{build_number}/"
    ipa_path = "#{ipa_folder}/#{target}.ipa"
    sh "mkdir -p #{ipa_folder}"

    # Export the IPA from the archive file created by the bot
    sh "xcrun xcodebuild -exportArchive -archivePath \"#{ENV['XCS_ARCHIVE']}\" -exportPath \"#{ipa_path}\" -IDEPostProgressNotifications=YES -DVTAllowServerCertificates=YES -DVTSigningCertificateSourceLogLevel=3 -DVTSigningCertificateManagerLogLevel=3 -DTDKProvisioningProfileExtraSearchPaths=/Library/Developer/XcodeServer/ProvisioningProfiles -exportOptionsPlist './ExportOptions.plist'"

    # Upload the build to iTunes Connect, it won't submit this IPA for review.
    deliver(
      force: true,
      ipa: ipa_path
    )

  end
end