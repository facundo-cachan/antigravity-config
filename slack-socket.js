import { App } from '@slack/bolt';

// Usar Slack Bolt para Socket Mode
const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  appToken: process.env.SLACK_APP_TOKEN,
  socketMode: true,
  port: process.env.PORT || 3000,
});

// Evento: cuando se recibe un mensaje en el canal
app.message(async ({ message, say, client }) => {
  console.log('\n📬 Mensaje recibido en canal:');
  console.log(JSON.stringify(message, null, 2));

  // Ignorar mensajes del propio bot
  if (message.subtype === 'bot_message' || message.subtype === 'bot_add') {
    console.log('   → Ignorando mensaje del bot');
    return;
  }

  if (!message.text) return;

  console.log(`   Usuario: ${message.user}`);
  console.log(`   Texto: ${message.text}`);
  console.log(`   Canal: ${message.channel}`);

  // Responder al canal o DM
  try {
    await say({
      text: `👋 ¡Gracias! Recebí tu mensaje: "${message.text}"`,
      thread_ts: message.ts
    });
    console.log('✅ Respuesta enviada');
  } catch (err) {
    console.error('❌ Error al responder:', err.message);
  }
});

// Evento de error
app.error(async (error) => {
  console.error('❌ Error:', error);
});

// Iniciar
(async () => {
  console.log('🔌 Iniciando Socket Mode con Slack Bolt...');
  await app.start();
  console.log('✅ Socket Mode conectado! Escuchando mensajes...');
  console.log('   - Canal: C0AQK2TMBV5');
  console.log('   - DMs también habilitados');
})();
