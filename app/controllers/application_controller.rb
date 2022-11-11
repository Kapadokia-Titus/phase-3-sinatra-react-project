class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  before do
    response.headers['Access-Control-Allow-Origin'] = "*"
  end

  #enable CORS prefLight requests
  options "*" do
    response.headers['Access-Control-Allow-Method'] = "GET, POST, PUT, PATCH, DELETE, OPTIONS"
  end
  
  # Add your routes here
  get "/" do
    { message: "Am Lucky to have a code that works on first instance" }.to_json
  end

  # get all users in the database
  get "/api/users" do
    User.all.to_json
  end

  #Get all users by ID
  get "/api/users/:id" do
    User.find(params[:id]).to_json
  end

  #allows for user creation,
  post "/api/users" do
    User.create(
      username: params[:username],
      email: params[:email],
      phone_number: params[:phone_number],
      gender: params[:gender],
      age: params[:age]
     )
  end

  # helps us to put/update user info
  put "/api/users/:id" do
    user = User.find(params[:id])
    user.update(
      username: params[:username]? params[:username]: user[:username],
      email: params[:email]? params[:email]: user[:email],
      phone_number: params[:phone_number]? params[:phone_number]: user[:phone_number],
      gender: params[:gender]? params[:gender]: user[:gender],
      age: params[:age]? params[:age]: user[:age]
    )

    user.to_json
  end

  # deletes user by id
  delete "/api/users/:id" do
    user = User.find(params[:id])
    user.destroy

    {message:"User Deleted Successfully"}.to_json
  end




  #====================================
  # PROJECT CONTROLLER SECTION
  #====================================

   # get all projects in the database
   get "/api/projects" do
    Project.all.to_json
  end



  #Get all projects by ID
  get "/api/projects/:id" do
    Project.find(params[:id]).to_json
  end

  #allows for projects creation,
  post "/api/projects" do
   
    Project.create(
      name: params[:name],
      creator: params[:creator],
      desc: params[:desc],
      timeframe: params[:timeframe],
      status: params[:status],
      scope: params[:scope],
      approach: params[:approach]
     )
  end

  # helps us to put/update projects info
  put "/api/projects/:id" do
    project = Project.find(params[:id])
    project.update(
      name: params[:name]? params[:name]: project[:name],
      creator: params[:creator]?  params[:creator]: project[:creator],
      desc: params[:desc]? params[:desc]: project[:desc],
      timeframe: params[:timeframe]? params[:timeframe]: project[:timeframe],
      status: params[:status]? params[:status]: project[:status],
      scope: params[:scope]? params[:scope]: project[:scope],
      approach: params[:approach]? params[:approach]: project[:approach]
    )

    project.to_json
  end

  # get deliverables by project id
  get "/api/projects/:id/deliverables" do
    data = Deliverable.where(project_id: params[:id])
    data ? data.to_json : {message: "Could Not find that deliverable"}.to_json
  end
   # get deliverables by project id
   get "/api/projects/:id/deliverables/:specific_id" do
    data = Deliverable.find(params[:specific_id])
    data ? data.to_json : {message: "Could Not find that deliverable"}.to_json
  end

  # update deliverables by project id
  put "/api/projects/:id/deliverables/:item_id" do
    #find the item by id
    item = Deliverable.find(params[:item_id])
    #update by project id
    item.update(
      name: params[:name]? params[:name] : item[:name],
      status: params[:status],
      assigned: params[:assigned]? params[:assigned] : item[:assigned]
     )
  end

   # deletes project deliverable by id
   delete "/api/projects/:id/deliverables/:item_id" do
    #find the item by id
    item = Deliverable.find(params[:item_id])
    item.destroy

    {message:"Project Deliverable Deleted Successfully"}.to_json
  end


  # post deliverables by project id
  post "/api/projects/:id/deliverables" do
    #find add by project id
    Deliverable.create(
      name: params[:name],
      project_id: params[:id],
      assigned: params[:assigned]
     )
  end


  # deletes projects by id
  delete "/api/projects/:id" do
    project = Project.find(params[:id])
    project.destroy

    {message:"Project Deleted Successfully"}.to_json
  end

end
