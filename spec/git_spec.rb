require 'spec_helper'
require 'toothpick/git'

describe Toothpick::Git do
  describe ".clone_repo" do
    let(:repo) { 'git@github.com:code-mancers/picks.git' }
    let(:target_dir) { '/home/emil' }
    let(:expected_git_command) { "git clone #{repo} #{target_dir}" }

    it "should git clone to target directory" do
      Toothpick::Git.should_receive(:system).with(expected_git_command)
      Toothpick::Git::clone_repo(repo, target_dir)
    end
  end

  describe ".on_git?" do
    context "when directory is on git" do
      it "should return true" do
        Toothpick::Git.on_git?(Dir.pwd).should be_true
      end
    end
    context "when directory is not on git" do
      it "should return false" do
        Toothpick::Git.on_git?('/tmp').should be_false
      end
    end
  end

  describe "Instance methods" do
    let(:git) { Toothpick::Git.new('/home/emil') }
    before(:each) do
      git.should_receive(:system).with(expected_git_command)
    end

    describe "#update" do
      let(:expected_git_command) do
        "cd /home/emil && git pull --rebase"
      end
      it "should git pull --rebase" do
        git.update
      end
    end

    describe "#commit" do
      let(:expected_git_command) do
        %r{cd /home/emil && git add --all && git commit}
      end
      it "should git add and commit without commit message" do
        git.commit
      end
    end

    describe "#push" do
      let(:expected_git_command) do
        "cd /home/emil && git push origin master"
      end
      it "should git push to origin master" do
        git.push
      end
    end
  end

end
