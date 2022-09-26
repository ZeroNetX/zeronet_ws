function cmd(cmd, params = {}) {
    console.log('sending cmd', cmd, params)
    document.frame.cmd(cmd, params, res => {
        console.log('received result', res)
    })
}

async function cmdp(cmd, params = {}) {
    console.log('sending cmdp', cmd, params);
    let result = await document.frame.cmdp(cmd, params)
    console.log('received result', result)
    return result
}

function onRequest(cmd, handler) {
    if (!document.frame.handlers) document.frame.handlers = []
    document.frame.handlers[cmd] = handler
    const defaultHandler = (cmd, msg) => document.frame.log("Unknown request", cmd, msg)
    document.frame.onRequest = (cmd, msg) => {
        (document.frame.handlers[cmd] || defaultHandler)(cmd, msg.params)
    }
}