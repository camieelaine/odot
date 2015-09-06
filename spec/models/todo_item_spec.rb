require 'rails_helper'

describe TodoItem do
  it { should belong_to(:todo_list) }
end

