contract BuggyProxy {
    address public implementation;
    address public admin;

    constructor(){
        admin = mdg.sender;
    }
    function _delegate() private{
        (bool ok, )= implementation.delegatecall(msg.data);
        require(ok, "delegatecall failed");
    }
    fallback() external payable{
        _delegate();
    }
    function upgradeTo(address _implementation)external{
        require(msg.sender == admin, "not authorized ");
        implementation = _implementation;

    }
}
