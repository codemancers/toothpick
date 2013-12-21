require 'spec_helper'
require 'support/fake_env'
require 'support/pickfile_shared_examples'
require 'support/git_shared_examples'
require 'toothpick/commands'

describe Toothpick::Commands do
  let(:git_repo) { 'git@github.com:code-mancers/picks.git' }
  let(:toothpick_home) { Toothpick::Commands::TOOTHPICK_HOME }
  let(:git) { double(Toothpick::Git) }

  describe "::TOOTHPICK_HOME" do
    it "should return .toothpick in user's home" do
      expect(toothpick_home).to eql('/home/user/.toothpick')
    end
  end

  describe ".init" do
    it "should clone the git repo" do
      Toothpick::Git.should_receive(:clone_repo).with(git_repo, toothpick_home)
      Toothpick::Commands::init(git_repo)
    end
  end

  describe ".new_pick" do
    before(:each) do
    end
    context "when toothpick init was done" do
      before(:each) do
        Toothpick::Git.should_receive(:on_git?).and_return(true)
      end

      include_examples "pickfile should be written successfully"
      include_examples "it should update, commit and push git"

      specify { Toothpick::Commands::new_pick }
    end

    context "when toothpick init was not done" do
      before(:each) do
        Toothpick::Git.should_receive(:on_git?).and_return(false)
      end

      it "should raise ToothpickNotInitialized error" do
        Toothpick::Git.should_not_receive(:new)
        expect { Toothpick::Commands::new_pick }
          .to raise_error(Toothpick::Errors::ToothpickNotInitialized)
      end
    end
  end
end
