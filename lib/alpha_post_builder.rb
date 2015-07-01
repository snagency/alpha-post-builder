require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require 'alpha_post_builder/builders/base_builder'

module AlphaPostBuilder
  def self.builder_class_name(network)
    "#{network}_builder".classify
  end

  def self.builder_class_path(network)
    "alpha_post_builder/builders/#{network}_builder"
  end

  NETWORKS = %i[direct_url facebook instagram twitter vkontakte yandex]
  NETWORKS.each do |network|
    autoload builder_class_name(network).to_sym, builder_class_path(network)
  end

  def self.filter(network, data)
    raise "Unrecognized network: #{network}" unless NETWORKS.include?(network)
    builder_class_name(network).constantize.filter(data)
  end

  def self.filter_collection(network, data)
    raise "Unrecognized network: #{network}" unless NETWORKS.include?(network)
    builder_class_name(network).constantize.filter_collection(data)
  end
end
