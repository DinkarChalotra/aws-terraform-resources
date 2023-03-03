# main.tf

variable "state_machine_name" {
  description = "The name of the Step Functions state machine"
}

variable "definition" {
  description = "The JSON definition of the state machine"
}

resource "aws_sfn_state_machine" "state_machine" {
  name       = var.state_machine_name
  definition = var.definition
}
