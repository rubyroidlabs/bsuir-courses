# Gets token from config.yaml
class Token
  def self.get
    config = YAML.load_file("config.yaml")
    config["config"]["token"]
  end
end
