
const Koa = require('koa');
const app = new Koa();
// const views = require('koa-views');
// const json = require('koa-json');
const onerror = require('koa-onerror');
// const bodyparser = require('koa-bodyparser');
const logger = require('koa-logger');

const index = require('./routes/index');
// error handler
onerror(app);

// middlewares
// app.use(bodyparser({
//     enableTypes: ['json', 'form', 'text'],
// }));
// app.use(json());
app.use(logger());
app.use(require('koa-static')(__dirname + '/build', {
    maxage: 1000 * 60 * 60 * 24 * 2, // 静态资源缓存2天
}));

// app.use(views(__dirname + '/views', {
//     extension: 'ejs',
// }));

// routes
app.use(index.routes(), index.allowedMethods());

// error-handling
app.on('error', (err, ctx) => {
    console.error('server error', err, ctx);
});

app.listen(3000);

module.exports = app;
