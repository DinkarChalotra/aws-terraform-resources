module "step_function" {
  source = "./step_function"
  
  state_machine_name = "my-state-machine"
  definition = <<DEFINITION
  {
    "Comment": "A simple state machine",
    "StartAt": "Hello",
    "States": {
      "Hello": {
        "Type": "Pass",
        "Result": "Hello, world!",
        "End": true
      }
    }
  }
  DEFINITION
}
