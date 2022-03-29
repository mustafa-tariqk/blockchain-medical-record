const Agent = artifacts.require("Agent");
const AgentGroup = artifacts.require("AgentGroup");
const AgentRegistry = artifacts.require("AgentRegistry");
const AllAccessRelationship = artifacts.require("AllAccessRelationship");
const DeadmanSwitch = artifacts.require("DeadmanSwitch");
const Relationship = artifacts.require("Relationship");

module.exports = function (deployer) {
  deployer.deploy(Agent);
  /**deployer.deploy(
    AgentRegistry,
    "TheFirstProvider",
    Agent.address,
    "127.0.0.1"
  );**/
};
