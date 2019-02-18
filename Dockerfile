# 设置基础镜像,如果没有该镜像，会从Docker.io服务器pull镜像
# 指定我们的基础镜像是node，版本是v10.9.0
FROM node:10.9.0
# 在服务器根目录下创建/home/service目录
RUN mkdir -p /home/service
# 相当于 cd 到 /home/service目录
WORKDIR /home/service

# 拷贝package.json文件到工作目录
# !!重要：package.json需要单独添加。
# Docker在构建镜像的时候，是一层一层构建的，仅当这一层有变化时，重新构建对应的层。
# 如果package.json和源代码一起添加到镜像，则每次修改源码都需要重新安装npm模块，这样木有必要。
# 所以，正确的顺序是: 添加package.json => 安装npm模块 => 添加源代码。
COPY package.json /home/service
# egg.js应用需要修改根目录下的package.json（普通node.js应用可忽略这一步）：
# 将start这行里命令里的--daemon去掉，即启动eggjs使用egg-scripts start就好了
# 在Docker里eggjs应用要在前台运行

# 安装安装npm模块项目依赖包
# RUN npm install --production --registry=https://registry.npm.taobao.org
RUN npm install --production --registry=https://registry.npm.taobao.org
RUN npm run build
# 拷贝所有源代码到工作目录
COPY ./build /home/service
COPY ./routes /home/service
COPY ./server.js /home/service

RUN pwd
RUN ls

# 暴露容器端口
EXPOSE 3000
# 启动node应用
CMD node server
