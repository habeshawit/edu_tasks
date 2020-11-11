class AssignmentsController < ApplicationController

  # GET: /assignments
  get "/assignments" do
    erb :"/assignments/index.html"
  end

  # GET: /assignments/new
  get "/assignments/new" do
    erb :"/assignments/new.html"
  end

  # POST: /assignments
  post "/assignments" do
    redirect "/assignments"
  end

  # GET: /assignments/5
  get "/assignments/:id" do
    erb :"/assignments/show.html"
  end

  # GET: /assignments/5/edit
  get "/assignments/:id/edit" do
    erb :"/assignments/edit.html"
  end

  # PATCH: /assignments/5
  patch "/assignments/:id" do
    redirect "/assignments/:id"
  end

  # DELETE: /assignments/5/delete
  delete "/assignments/:id/delete" do
    redirect "/assignments"
  end
end
