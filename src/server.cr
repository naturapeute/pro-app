require "grip"
require "crinja"


class HTMLController < Grip::Controllers::Http
  @tpl = Crinja.new

  def initialize()
    @tpl.loader = Crinja::Loader::FileSystemLoader.new("views/")
  end

  def render(context, template : String, hash : Hash | Nil = nil)
    context
      .html(@tpl.get_template(template).render(hash))
  end
end


class ServerController < HTMLController
  def get(context)
    self.render(context, "index.html")
  end
end


class Application < Grip::Application
  def initialize
    get "/", ServerController
  end
end

app = Application.new
app.run
