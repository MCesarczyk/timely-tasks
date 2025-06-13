require 'swagger_helper'

RSpec.describe 'tasks', type: :request do
  path '/tasks' do
    post 'Creates a new task' do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Buy groceries' },
          content: { type: :string, example: 'Milk, Bread, Eggs' },
          completed: { type: :boolean, example: false }
        },
        required: [ 'title', 'content' ]
      }
      response '201', 'task created' do
        let(:task) { { title: 'Buy groceries', content: 'Milk, Bread, Eggs', completed: false } }
        run_test!
      end
      response '422', 'invalid request' do
        let(:task) { { title: 'Buy nothing', content: '' } } # Invalid task without content
        run_test!
      end
    end

    get 'Retrieves all tasks' do
      tags 'Tasks'
      produces 'application/json'

      response '200', 'tasks found' do
        run_test!
      end
    end
  end

  path '/tasks/{id}' do
    get 'Retrieves a task' do
      tags 'Tasks'
      parameter name: :id, in: :path, type: :integer, description: 'Task ID'
      produces 'application/json'
      response '200', 'task found' do
        let(:id) { 1 } # Assuming task with ID 1 exists
        run_test!
      end
      response '404', 'task not found' do
        let(:id) { 9999 } # Non-existent task ID
        run_test!
      end
    end

    put 'Updates a task' do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Task ID'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Buy groceries' },
          content: { type: :string, example: 'Milk, Bread, Eggs' },
          completed: { type: :boolean, example: false }
        },
        required: [ 'title' ]
      }

      response '200', 'task updated' do
        let(:id) { 1 }
        let(:task) { { title: 'Buy groceries', content: 'Milk, Bread, Eggs', completed: false } }
        run_test!
      end

      response '404', 'task not found' do
        let(:id) { 9999 } # Non-existent task ID
        let(:task) { { title: 'Buy groceries' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { 1 }
        let(:task) { { title: '' } } # Invalid task without title
        run_test!
      end
    end

    delete 'Deletes a task' do
      tags 'Tasks'
      parameter name: :id, in: :path, type: :integer, description: 'Task ID'

      response '204', 'task deleted' do
        let(:id) { 1 } # Assuming task with ID 1 exists
        run_test!
      end

      response '404', 'task not found' do
        let(:id) { 9999 } # Non-existent task ID
        run_test!
      end
    end
  end
end
