require "grip"
require "crinja"


class ServerController < Grip::Controllers::Http
  def get(context)
    env = Crinja.new
    env.loader = Crinja::Loader::FileSystemLoader.new("views/")
    context
      .html(env.get_template("index.html").render({ "name" => "there" }))
  end
end

class Application < Grip::Application
  def initialize
    get "/", ServerController
  end
end

app = Application.new
app.run
