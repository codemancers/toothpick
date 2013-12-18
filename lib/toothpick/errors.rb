module Toothpick
  module Errors
    class ToothpickError < StandardError; end;
    class ToothpickNotInitialized < ToothpickError; end;
  end
end
