const router = require('koa-router')();

router.get('/', async ctx => {
    await ctx.redirect('/index.html');
});

module.exports = router;
