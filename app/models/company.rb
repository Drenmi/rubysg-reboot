require 'yaml'

class Company
  include ActiveModel::Model

  attr_accessor(
    :name,
    :website,
    :logo_url,
    :address,
    :hiring_url,
    :email
  )

  validates_presence_of(
    :name,
    :website,
    :logo_url,
    :address,
    :email
  )

  class << self

    def all
      companies.map { |company| Company.new(company) }.sort_by {|company| company.name.downcase }
    end

    def companies

      return @companies if @companies

      File.open(File.join(File.dirname(__FILE__), "companies.yml")) do |file|
        @companies = YAML.load(file).to_ary
      end

      @companies
    end
  end
end
