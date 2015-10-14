require 'spec_helper'
require 'lazybird/lazybird_facade'
require 'lazybird/db'
# Smoke test

describe 'lazybird_facade' do

  let(:facade) { Lazybird::LazybirdFacade.new }

  def get_tmp_filename
    "#{Dir.tmpdir()}/#{Dir::Tmpname.make_tmpname('lazybird', nil)}"
  end

  before(:each) do
    @tmp_db = get_tmp_filename
    allow(Lazybird::Db).to receive(:db) { Sequel.amalgalite(@tmp_db) }
    Lazybird::Db.init
  end

  after(:each) do
    File.delete(@tmp_db)
  end

  it 'displays a hash of tasks' do
    expect(facade.tasks).to be_a Hash
  end

  it 'adds a known task' do
    task = facade.tasks.keys.first
    expect { facade.add_task(task) }.to change { facade.current_tasks.count }.from(0).to(1)
  end

  it 'removes a known task' do
    task = facade.tasks.keys.first
    facade.add_task(task)
    expect { facade.rem_task(task) }.to change { facade.current_tasks.count }.by(-1)
  end

  describe 'config' do

    let(:conf) { ['1', '2', '3', '4'] }

    before(:each) do
      facade.config(conf)
    end

    it 'stores a default twitter config' do
      expect(Lazybird::Config.client).to be_a(Twitter::REST::Client)
    end
  end

  describe 'task runner' do
    xit 'runs a dummy task now' do

    end

    xit 'runs a dummy task in 1 second' do

    end

    xit 'shows info about a current task' do

    end
  end
end