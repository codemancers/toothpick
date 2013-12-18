module Toothpick
  class Search

    def initialize(picks_dir, string)
      # Works only with the_silver_searcher for now
      unless `cd #{picks_dir} && ag --version`.nil?
        space_separated_filenames = `ag -l #{string}`
        unless space_separated_filenames.empty?
          system("$EDITOR #{space_separated_filenames}")
        end
      end
    end

  end
end
