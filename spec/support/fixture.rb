require 'json'

def load_fixture_for(network)
  data = JSON.parse File.read("spec/fixtures/#{network}.json")
  recursive_symbolize_keys data
end

private

def recursive_symbolize_keys(_hash)
  case _hash
  when Hash
    Hash[
      _hash.map do |key, value|
        [ key.respond_to?(:to_sym) ? key.to_sym : key, recursive_symbolize_keys(value) ]
      end
    ]
  when Enumerable
    _hash.map { |value| recursive_symbolize_keys(value) }
  else
    _hash
  end
end
