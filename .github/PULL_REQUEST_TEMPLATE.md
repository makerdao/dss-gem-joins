# Description

Collateral Type (e.g. `ETH-A`):

COB Team Name or Author(s):

GemJoin Adapter:

Is this GemJoin adapter new? :

If so, why is a new one needed? :


# Contribution Checklist

- [ ] Collateral token contract has been added in `src/tokens/` as `TOKEN.sol`, if not already present
- [ ] If needed, a new `GemJoin` has been added in `src/` as `join-X.sol`
- [ ] A new test (`testGemJoinX_TOKEN()`) has been added to `src/join.t.sol` and follows previous tests as examples
- [ ] If needed, other tests have been added to verify functionality of the new `GemJoin`:
    - [ ] `testFailGemJoinXJoinWad()`
    - [ ] `testFailGemJoinXExitWad()`
    - [ ] `testFailGemJoinXJoin()`
    - [ ] `testFailGemJoinXExit()`
    - [ ] `testFailJoinAfterCageGemJoinX()`
- [ ] README has been updated to reflect a new token and `GemJoin` addition

# Checklist

- [ ] Confirm that token contract matches the verified source on etherscan mainnet
- [ ] If a new `GemJoin` is added, ensure the above description is accurate
- [ ] If a new `GemJoin` is added, ensure a new `GemJoin` has been added with the correct name
- [ ] Ensure README is updated
- [ ] Manually review the new test(s)
- [ ] Manually run dapp tests in `src/join.t.sol` to confirm they all pass
