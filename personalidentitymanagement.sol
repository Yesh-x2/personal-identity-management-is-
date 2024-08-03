// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
contract PersonalIdentityManagement {
 
    // Define a struct to hold personal information
    struct Identity {
        string name;
        string email;
        string phoneNumber;
        string aadhaar;
        string pan;
        bool isVerified;
    }
 
    // Mapping from address to Identity
    mapping(address => Identity) private identities;
 
    // Event to log identity creation
    event IdentityCreated(address indexed user, string name, string email, string phoneNumber, string aadhaar, string pan);
    
    // Event to log identity verification
    event IdentityVerified(address indexed user);
 
    // Modifier to ensure only the owner can access certain functions
    modifier onlyOwner(address _user) {
        require(msg.sender == _user, "You are not the owner of this identity.");
        _;
    }
 
    // Function to create a new identity
    function createIdentity(
        string memory _name,
        string memory _email,
        string memory _phoneNumber,
        string memory _aadhaar,
        string memory _pan
    ) public {
        Identity storage identity = identities[msg.sender];
        identity.name = _name;
        identity.email = _email;
        identity.phoneNumber = _phoneNumber;
        identity.aadhaar = _aadhaar;
        identity.pan = _pan;
        identity.isVerified = false;
 
        emit IdentityCreated(msg.sender, _name, _email, _phoneNumber, _aadhaar, _pan);
    }
 
    // Function to verify an identity
    function verifyIdentity(address _user) public onlyOwner(_user) {
        Identity storage identity = identities[_user];
        require(bytes(identity.name).length != 0, "Identity does not exist.");
        identity.isVerified = true;
 
        emit IdentityVerified(_user);
    }
 
    // Function to get identity details
    function getIdentity(address _user) public view returns (
        string memory,
        string memory,
        string memory,
        string memory,
        string memory,
        bool
    ) {
        Identity storage identity = identities[_user];
        require(bytes(identity.name).length != 0, "Identity does not exist.");
        return (
            identity.name,
            identity.email,
            identity.phoneNumber,
            identity.aadhaar,
            identity.pan,
            identity.isVerified
        );
    }
 
    // Function to update identity details
    function updateIdentity(
        string memory _name,
        string memory _email,
        string memory _phoneNumber,
        string memory _aadhaar,
        string memory _pan
    ) public {
        Identity storage identity = identities[msg.sender];
        require(bytes(identity.name).length != 0, "Identity does not exist.");
        identity.name = _name;
        identity.email = _email;
        identity.phoneNumber = _phoneNumber;
        identity.aadhaar = _aadhaar;
        identity.pan = _pan;
 
        emit IdentityCreated(msg.sender, _name, _email, _phoneNumber, _aadhaar, _pan); // Reusing the same event for update
    }
}