require 'spec_helper'
require 'lazybird/tasks/task'

describe 'tests the parent task' do

  let(:command) { 'my_command' }
  let(:task) { Lazybird::Tasks::Task.new(command: command) }

  it 'displays the command' do
    expect(task.command).to eq(command)
  end

  it 'throws an exception if run is called' do
    expect { task.run }.to raise_error(NotImplementedError)
  end
end