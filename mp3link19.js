process.argv[2] || process.exit(1);
var aaa=process.argv[2];
var vk={id: 2989357};
var         //d = i("6ng+"),
		_ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMN0PQRSTUVWXYZO123456789+/="
          , c = {
            v: function(t) {
                return t.split("").reverse().join("")
            },
            r: function(t, e) {
                t = t.split("");
                for (var i, o = _ + _, a = t.length; a--; )
                    ~(i = o.indexOf(t[a])) && (t[a] = o.substr(i - e, 1));
                return t.join("")
            },
            s: function(t, e) {
                var i = t.length;
                if (i) {
                    var o = function(t, e) {
                        var i = t.length
                          , o = [];
                        if (i) {
                            var a = i;
                            for (e = Math.abs(e); a--; )
                                e = (i * (a + 1) ^ e + a) % i,
                                o[a] = e
                        }
                        return o
                    }(t, e)
                      , a = 0;
                    for (t = t.split(""); ++a < i; )
                        t[a] = t.splice(o[i - 1 - a], 1, t[a])[0];
                    t = t.join("")
                }
                return t
            },
            i: function(t, e) {
                return c.s(t, e ^ vk.id)
            },
            x: function(t, e) {
                var i = [];
                return e = e.charCodeAt(0),
                each(t.split(""), function(t, o) {
                    i.push(String.fromCharCode(o.charCodeAt(0) ^ e))
                }),
                i.join("")
            }
        };
       function p(t) {
            if (/*(!window.wbopen || !~(window.open + "").indexOf("wbopen")) &&*/ ~t.indexOf("audio_api_unavailable")) {
                var e = t.split("?extra=")[1].split("#")
                  , i = "" === e[1] ? "" : h(e[1]);
//console.log(e[1]);process.exit();
                if (e = h(e[0]),
                "string" != typeof i || !e)
                    return t;
                for (var o, a, s = (i = i ? i.split(String.fromCharCode(9)) : []).length; s--; ) {
                    if (o = (a = i[s].split(String.fromCharCode(11))).splice(0, 1, e)[0],
                    !c[o])
                        return t;
                    e = c[o].apply(null, a)
                }
                if (e && "http" === e.substr(0, 4))
                    return e
            }
            return t
        }
        function h(t) {
            if (!t || t.length % 4 == 1)
                return !1;
            for (var e, i, o = 0, a = 0, s = ""; i = t.charAt(a++); )
                ~(i = _.indexOf(i)) && (e = o % 4 ? 64 * e + i : i,
                o++ % 4) && (s += String.fromCharCode(255 & e >> (-2 * o & 6)));
            return s
        }

console.log(p(aaa));
