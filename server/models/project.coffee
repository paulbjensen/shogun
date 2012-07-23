global.Projects = new Schema
  name                : String
  userId              : ObjectId
  createdAt           : type: Date, default: Date.now
  updatedAt           : type: Date, default: Date.now

global.Project = mongoose.model 'Project', Projects