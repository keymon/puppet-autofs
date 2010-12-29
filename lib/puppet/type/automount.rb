module Puppet
  # We want the mount to refresh when it changes.
  newtype(:automount, :self_refresh => true) do
    @doc = "Manages automounted filesystems, changing the automount filesystem.
      
      It will not restart the automount daemon or reload the filesystems, it
      only modifies the /etc/auto.master file.
      
      It does not manage the map files.
      "

    ensurable
    
    newparam(:name) do
      desc "The mount path for the mount."

      isnamevar
    end

    newproperty(:map) do
      desc "The map file or reference for this entry."
    end

    newproperty(:options) do
      desc "Mount options for the mounts, as they would
        appear in the auto.master."
    end

    def refresh
    end

  end
end
