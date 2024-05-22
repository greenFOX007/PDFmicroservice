# Use Node.js LTS version
FROM node:20

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install --only=production

# Bundle app source
COPY . .

RUN echo "deb http://ftp.us.debian.org/debian bookworm main" > /etc/apt/sources.list

# Install Puppeteer dependencies
RUN apt-get update && apt-get install -y \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    fonts-liberation \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 



RUN apt-get update && apt-get install -y \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils \
    wget \
    unzip \
    fontconfig 

# Копирование шрифтов из папки проекта в контейнер
COPY ./fonts/ /tmp/fonts/

# Установка шрифта Manrope
RUN mkdir -p /usr/share/fonts/truetype/manrope && \
    mv /tmp/fonts/Manrope-Bold.ttf /usr/share/fonts/truetype/manrope/Manrope-Bold.ttf && \
    mv /tmp/fonts/Manrope-ExtraBold.ttf /usr/share/fonts/truetype/manrope/Manrope-ExtraBold.ttf && \
    mv /tmp/fonts/Manrope-Light.ttf /usr/share/fonts/truetype/manrope/Manrope-Light.ttf && \
    mv /tmp/fonts/Manrope-ExtraLight.ttf /usr/share/fonts/truetype/manrope/Manrope-ExtraLight.ttf && \
    mv /tmp/fonts/Manrope-Medium.ttf /usr/share/fonts/truetype/manrope/Manrope-Medium.ttf && \
    mv /tmp/fonts/Manrope-Regular.ttf /usr/share/fonts/truetype/manrope/Manrope-Regular.ttf && \
    mv /tmp/fonts/Manrope-SemiBold.ttf /usr/share/fonts/truetype/manrope/Manrope-SemiBold.ttf && \
    # Добавьте аналогичные строки для других файлов шрифта Manrope
    fc-cache -f -v

# Установка шрифта Red Hat Display
RUN mkdir -p /usr/share/fonts/truetype/redhat-display && \
    mv /tmp/fonts/RedHatDisplay-Black.ttf /usr/share/fonts/truetype/redhat-display/RedHatDisplay-Black.ttf && \
    mv /tmp/fonts/RedHatDisplay-Bold.ttf /usr/share/fonts/truetype/redhat-display/RedHatDisplay-Bold.ttf && \
    mv /tmp/fonts/RedHatDisplay-Medium.ttf /usr/share/fonts/truetype/redhat-display/RedHatDisplay-Medium.ttf && \
    mv /tmp/fonts/RedHatDisplay-Regular.ttf /usr/share/fonts/truetype/redhat-display/RedHatDisplay-Regular.ttf && \
    # Добавьте аналогичные строки для других файлов шрифта Red Hat Display
    fc-cache -f -v

# Expose the port
EXPOSE 3001

# Start the app
CMD [ "npm", "start" ]
