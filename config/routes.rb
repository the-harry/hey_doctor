HeyDoctor::Engine.routes.draw do
  root to: proc { [200, {}, ['']] }
end
