module Snapshot
  class DependencyChecker
    def self.check_dependencies
      self.check_xcode_select
      self.check_simulators
      self.check_xctool
    end

    def self.check_xcode_select
      unless `xcode-select -v`.include?"xcode-select version "
        Helper.log.fatal '#############################################################'
        Helper.log.fatal "# You have to install the Xcode commdand line tools to use deliver"
        Helper.log.fatal "# Install the latest version of Xcode from the AppStore"
        Helper.log.fatal "# Run xcode-select --install to install the developer tools"
        Helper.log.fatal '#############################################################'
        raise "Run 'xcode-select --install' and start deliver again"
      end
    end

    def self.check_simulators
      Helper.log.debug "Found #{SnapshotFile.available_devices.count} simulators."
      if SnapshotFile.available_devices.count < 1
        Helper.log.fatal '#############################################################'
        Helper.log.fatal "# You have to add new simulators using Xcode"
        Helper.log.fatal "# Xcode => Window => Devices"
        Helper.log.fatal '#############################################################'
        raise "Create the new simulators and run this script again"
      end
    end

    def self.xctool_installed?
      return `which xctool`.length > 1
    end

    def self.check_xctool
      if not self.xctool_installed?
        Helper.log.error '#############################################################'
        Helper.log.error "# xctool is recommended to build the apps"
        Helper.log.error "# Install it using 'brew install xctool'"
        Helper.log.error "# Falling back to xcode build instead "
        Helper.log.error '#############################################################'
      end
    end
  end
end