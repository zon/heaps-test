import {Server} from 'colyseus';
import {createServer} from 'http';
import Koa from 'koa';
import { GameRoom } from './GameRoom';

const app = new Koa();
const port = Number(process.env.port) || 3000;

app.use(ctx => {
	ctx.body = true;
});

const server = new Server({
	server: createServer(app.callback())
});
server.define('entry', GameRoom)
server.listen(port)
console.log(`Listening on ws://localhost:${port}`)
