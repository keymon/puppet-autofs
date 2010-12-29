require 'puppet/provider/parsedfile'

auto_master = nil
case Facter.value(:operatingsystem)
when "AIX";
  auto_master = "/etc/auto_master"
else
  auto_master = "/etc/auto.master"
end


Puppet::Type.type(:automount).provide(
  :parsed,
  :parent => Puppet::Provider::ParsedFile,
  :default_target => auto_master,
  :filetype => :flat
) do

  @fields = [:name, :map, :options]
  @fielddefaults = [ nil ] * 3 

  optional_fields  = @fields - [:name, :map]
  mandatory_fields = @fields - optional_fields

  text_line :comment, :match => /^\s*#/
  text_line :blank, :match => /^\s*$/

  # fstab will ignore lines that have fewer than the mandatory number of columns,
  # so we should, too.
  field_pattern = '(\s*(?>\S+))'
  text_line :incomplete, :match => /^(?!#{field_pattern}{#{mandatory_fields.length}})/

  record_line self.name, :fields => @fields, :separator => /\s+/, :joiner => "\t", :optional => optional_fields

end

