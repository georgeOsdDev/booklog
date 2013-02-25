var   should,expect;
if (typeof require === "function"){
  should  = require("chai").should(),
  expect  = require("chai").expect;
} else {
  should  = chai.should();
  expect  = chai.expect;
}

describe("Sample Test",function(){
  beforeEach(function() {
    console.log("before each");
  });
  it("should be",function(){
    true.should.equal(true);
  });
});
