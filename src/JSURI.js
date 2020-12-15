"use strict";

// A version of encodeURIComponent which is compliant with RFC3896, as described
// in the MDN documentation here:
//
// https://web.archive.org/web/20201206001047/https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent
exports._encodeURIComponent = function encode(fail, succeed, input) {
  try {
    var encoded = encodeURIComponent(input).replace(/[!'()*]/g, function (c) {
      return "%" + c.charCodeAt(0).toString(16);
    });
    return succeed(encoded);
  } catch (err) {
    return fail(err);
  }
};

exports._decodeURIComponent = function decode(fail, succeed, input) {
  try {
    var decoded = decodeURIComponent(input);
    return succeed(decoded);
  } catch (err) {
    return fail(err);
  }
};
