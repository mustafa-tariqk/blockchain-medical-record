import React, { Component } from "react";

import Agent from "../abis/Agent.json";
import AgentGroup from "../abis/AgentGroup.json";
import AgentRegistry from "../abis/AgentRegistry.json";
import AllAccessRelationship from "../abis/AllAccessRelationship.json";
import DeadmanSwitch from "../abis/DeadmanSwitch.json";
import Relationship from "../abis/Relationship.json";

import Web3 from "web3";

import Container from "react-bootstrap/Container";
import Spinner from "react-bootstrap/Spinner";
import Button from "react-bootstrap/Button";
import Table from "react-bootstrap/Table";
import Image from "react-bootstrap/Image";
import Card from "react-bootstrap/Card";
import Row from "react-bootstrap/Row";
import Col from "react-bootstrap/Col";

import makeBlockie from "ethereum-blockies-base64";

import "./App.css";
import networkOverview from "../NetworkOverview.png";

class App extends Component {
  constructor(props) {
    super(props);

    const path = window.location.pathname.replaceAll("/", "");

    this.state = {
      loading: true,
      path,
    };

    this.loadThings();
  }

  async loadThings() {
    await this.initWeb3();

    this.setState({ loading: false });
  }

  async initWeb3() {
    //Ensures user has an Ethereum wallet on their website
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum);
      await window.ethereum.request({ method: "eth_requestAccounts" });
    } else {
      window.alert("No wallet detected");
    }

    const web3 = window.web3;
    this.setState({ web3 });

    window.ethereum.on("chainChanged", (_chainId) =>
      window.location.reload(false)
    );
    window.ethereum.on("accountsChanged", (_accountId) =>
      window.location.reload(false)
    );

    // Adds the user's address to the state
    const accounts = await web3.eth.getAccounts();
    this.setState({ account: accounts[0] });

    //const latestBlock = await web3.eth.getBlockNumber();
    //this.setState({ latestBlock });

    // Ensures the contract was published to the current network
    const networkId = await web3.eth.net.getId();
    const networkData = Agent.networks[networkId];

    if (networkData) {
      const agent = new web3.eth.Contract(Agent.abi, networkData.address);
      this.setState({ agent });
    } else {
      // If contract is not on current network, then request switch to Ethereum
      try {
        await window.ethereum.request({
          method: "wallet_switchEthereumChain",
          params: [{ chainId: "0x539" }],
        });
      } catch (switchError) {
        // This error code indicates that the chain has not been added to MetaMask.
        if (switchError.code === 4902) {
          try {
            await window.ethereum.request({
              method: "wallet_addEthereumChain",
              params: [
                {
                  chainId: "0x539",
                  chainName: "Ganache",
                  nativeCurrency: {
                    name: "QMIND",
                    symbol: "QMIND",
                    decimals: 18,
                  },
                  rpcUrls: ["http://127.0.0.1:7545"],
                },
              ],
            });
          } catch (addError) {}
        }
      }
      window.location.reload(false);
    }
  }

  render() {
    return (
      <div>
        {this.state.loading ? (
          <div className="text-center mt-5">
            <Spinner
              className="mx-auto d-block"
              animation="border"
              role="status"
            />
            <p>Waiting for Wallet</p>
          </div>
        ) : (
          <Container style={{ marginLeft: 0 }}>
            <Row>
              <Col
                sm={4}
                style={{ backgroundColor: "#E5E9F0", height: "100vh" }}
              >
                <Table borderless>
                  <tbody>
                    <tr>
                      <td>First Name:</td>
                      <td>John</td>
                    </tr>
                    <tr>
                      <td>Last Name:</td>
                      <td>Doe</td>
                    </tr>
                    <tr>
                      <td>Contract:</td>
                      <td>Agent</td>
                    </tr>
                  </tbody>
                </Table>

                <Button variant="light" size="sm" block>
                  Home
                </Button>

                <Button variant="light" size="sm" block>
                  Your Network
                </Button>

                <Button variant="light" size="sm" block>
                  Edit Relationships
                </Button>
              </Col>
              <Col>
                <Image fluid src={networkOverview} />
              </Col>
            </Row>
          </Container>
        )}
      </div>
    );
  }
}

export default App;
