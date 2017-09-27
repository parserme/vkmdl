process.argv[2] || process.exit(1);
var aaa=process.argv[2];
//"https:\/\/vk.com\/mp3\/audio_api_unavailable.mp3?extra=Aenfz3eYEMjLB3q5wxbhotDVyvbhAMftneOTwtnAExbWvgTZDNnHnKrxx2fxAvfmrfrFuueVmLjfzxLOoI9eBxjxCZf0lOnImdboDKfzEgniyZrezwTfoe9Yv2XPy3LvDgftvwqOEhnpmMHjmL9JlJfmAZ9gyOv4yxu5zuXguZGYwtjTl2rxmLvODhj6vgmTvOeTpwzzDJzYs3zrmvfWzu9OovjZCdaUoxy5A282sdbOvOLWlLvLm3qYqZnUrhrPsW#CWS2nJa";
    var n = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMN0PQRSTUVWXYZO123456789+/="
      , i = {
        v: function(e) {
            return e.split("").reverse().join("")
        },
        r: function(e, t) {
            e = e.split("");
            for (var i, a = n + n, r = e.length; r--; )
                i = a.indexOf(e[r]),
                ~i && (e[r] = a.substr(i - t, 1));
            return e.join("")
        },
        s: function(e, t) {
            var n = e.length;
            if (n) {
                var i = s(e, t)
                  , a = 0;
                for (e = e.split(""); ++a < n; )
                    e[a] = e.splice(i[n - 1 - a], 1, e[a])[0];
                e = e.join("")
            }
            return e
        },
        x: function(e, t) {
            var n = [];
            return t = t.charCodeAt(0),
            each(e.split(""), function(e, i) {
                n.push(String.fromCharCode(i.charCodeAt(0) ^ t))
            }),
            n.join("")
        }
    };
    function a() {
        return false;//window.wbopen && ~(window.open + "").indexOf("wbopen")
    }
    function r(e) {
        if (!a() && ~e.indexOf("audio_api_unavailable")) {
            var t = e.split("?extra=")[1].split("#")
              , n = "" === t[1] ? "" : o(t[1]);
            if (t = o(t[0]),
            "string" != typeof n || !t)
                return e;
            n = n ? n.split(String.fromCharCode(9)) : [];
            for (var r, s, l = n.length; l--; ) {
                if (s = n[l].split(String.fromCharCode(11)),
                r = s.splice(0, 1, t)[0],
                !i[r])
                    return e;
                t = i[r].apply(null, s)
            }
            if (t && "http" === t.substr(0, 4))
                return t
        }
        return e
    }
    function o(e) {
        if (!e || e.length % 4 == 1)
            return !1;
        for (var t, i, a = 0, r = 0, o = ""; i = e.charAt(r++); )
            i = n.indexOf(i),
            ~i && (t = a % 4 ? 64 * t + i : i,
            a++ % 4) && (o += String.fromCharCode(255 & t >> (-2 * a & 6)));
        return o
    }

    function s(e, t) {
        var n = e.length
          , i = [];
        if (n) {
            var a = n;
            for (t = Math.abs(t); a--; )
                i[a] = (t += t * (a + n) / t) % n | 0
        }
        return i
    }
console.log(r(aaa));