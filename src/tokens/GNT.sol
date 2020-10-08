pragma solidity >=0.5.12;

contract GNT {
    function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x + y) >= x, "ds-math-add-overflow");
    }
    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x, "ds-math-sub-underflow");
    }
    event Transfer(address indexed src, address indexed dst, uint256 wad);

    string  public  name = "GNT";
    string  public  symbol = "GNT";
    uint256 public  decimals = 18;
    uint256                        _supply;
    mapping (address => uint256)   _balances;

    constructor(uint256 supply) public {
        _balances[msg.sender] = supply;
        _supply = supply;
    }

    function totalSupply() public view returns (uint256) {
        return _supply;
    }
    function balanceOf(address src) public view returns (uint256) {
        return _balances[src];
    }

    function transfer(address dst, uint256 wad) public returns (bool) {
        require(_balances[msg.sender] >= wad, "insufficient-balance");
        _balances[msg.sender] = sub(_balances[msg.sender], wad);
        _balances[dst] = add(_balances[dst], wad);

        emit Transfer(msg.sender, dst, wad);

        return true;
    }
}
