HeyDoctor::Engine.routes.draw do
  get '/', to: proc { [200, {}, ['']] }
end
