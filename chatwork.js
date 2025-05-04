const axios = require('axios');

class Chatwork {
  constructor(token) {
    this.token = token;
    this.baseUrl = 'https://api.chatwork.com/v2';
  }

  async sendMessage(roomId, message) {
    try {
      const response = await axios.post(
        `${this.baseUrl}/rooms/${roomId}/messages`,
        {
          body: message
        },
        {
          headers: {
            'X-ChatWorkToken': this.token,
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }
      );
      return response.data;
    } catch (error) {
      console.error('Error sending Chatwork message:', error);
      throw error;
    }
  }
}

module.exports = Chatwork; 