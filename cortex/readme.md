# AI Concierge System - n8n Implementation

## Overview

This is a comprehensive AI assistant system that provides a unified conversational interface across Discord, SMS, and Telegram. The system uses GPT-4 with tool-calling capabilities to manage calendars, email, tasks, notes, and files.

## System Architecture

### Workflows

1. **Channel Ingest Workflows** (5 workflows)
   - `channel_discord_dm.json` - Handles Discord DMs (text & voice)
   - `channel_discord_mention.json` - Handles Discord channel mentions
   - `channel_discord_voice.json` - Handles Discord voice channel commands
   - `channel_sms.json` - Handles SMS via Twilio
   - `channel_telegram.json` - Handles Telegram messages

2. **Core Processing** (1 workflow)
   - `primary_ai.json` - Main AI processing with tool execution

3. **Response Handling** (1 workflow)
   - `outbound_dispatcher.json` - Routes responses back to users

4. **System Management** (2 workflows)
   - `error_handler.json` - Centralized error handling
   - `health_check.json` - System health monitoring endpoint

## Environment Variables

Set these environment variables in your n8n instance:

```bash
# LLM Configuration
LITELLM_BASE_URL=https://litellm.nerdz.cloud/v1
LITELLM_API_KEY=your_litellm_api_key

# Discord Configuration
DISCORD_BOT_TOKEN=your_discord_bot_token
DISCORD_USER_ID=212103531446927362
DISCORD_SERVER_ID=1175866333829791814
DISCORD_CHANNEL_ID=1374274241888784384
DISCORD_ERROR_CHANNEL_ID=1374302440324599808

# SMS Configuration (Twilio)
TWILIO_ACCOUNT_SID=your_twilio_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_PHONE_NUMBER=+447476550411
GAVIN_PHONE_NUMBER=+6421467267

# Telegram Configuration
TELEGRAM_BOT_TOKEN=your_telegram_bot_token
TELEGRAM_USERNAME=nzvengeance

# Database Configuration
POSTGRES_HOST=your_postgres_host
POSTGRES_PORT=5432
POSTGRES_DATABASE=ai_assistant
POSTGRES_USER=your_postgres_user
POSTGRES_PASSWORD=your_postgres_password

# Redis Configuration
REDIS_HOST=your_redis_host
REDIS_PORT=6379
REDIS_PASSWORD=your_redis_password

# Vector Database Configuration
QDRANT_URL=https://qdrant.nerdz.cloud
QDRANT_API_KEY=your_qdrant_api_key

# Memory Configuration
ZEP_URL=https://zep.nerdz.cloud
ZEP_API_KEY=your_zep_api_key

# Voice Configuration
ELEVENLABS_API_KEY=your_elevenlabs_api_key
ELEVENLABS_VOICE_ID=your_voice_id

# Tool Integrations
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
TODOIST_API_TOKEN=your_todoist_token
AIRTABLE_API_KEY=your_airtable_api_key
OBSIDIAN_API_URL=https://obsidian-api.nerdz.cloud
OBSIDIAN_API_KEY=your_obsidian_api_key
```

## Required Credentials

Create these credentials in n8n:

### 1. Discord Bot
- Type: OAuth2
- Client ID & Secret from Discord Developer Portal
- Bot Permissions: Send Messages, Read Messages, Connect, Speak, Use Voice Activity

### 2. OpenAI/Whisper
- Type: API Key
- Used for voice transcription

### 3. LiteLLM
- Type: HTTP Header Auth
- Header Name: `Authorization`
- Header Value: `Bearer YOUR_API_KEY`

### 4. Twilio
- Type: API Key
- Account SID & Auth Token

### 5. Telegram Bot
- Type: API Key
- Bot Token from BotFather

### 6. Google OAuth
- Type: OAuth2
- Scopes: Calendar, Gmail, Drive, Docs, Sheets, Slides

### 7. Todoist
- Type: API Key

### 8. Airtable
- Type: API Key

### 9. Postgres
- Type: Database Connection

### 10. Redis
- Type: Connection String

### 11. Qdrant
- Type: HTTP Header Auth
- Header Name: `api-key`

### 12. Zep
- Type: HTTP Header Auth
- Header Name: `Authorization`
- Header Value: `Bearer YOUR_API_KEY`

### 13. ElevenLabs
- Type: HTTP Header Auth
- Header Name: `xi-api-key`

### 14. Obsidian API
- Type: HTTP Header Auth

## Database Setup

### PostgreSQL Tables

```sql
-- Discord events table
CREATE TABLE discord_events (
    id SERIAL PRIMARY KEY,
    channel VARCHAR(50),
    modality VARCHAR(20),
    content TEXT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Discord voice events table
CREATE TABLE discord_voice_events (
    id SERIAL PRIMARY KEY,
    channel VARCHAR(50),
    modality VARCHAR(20),
    content TEXT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SMS events table
CREATE TABLE sms_events (
    id SERIAL PRIMARY KEY,
    channel VARCHAR(50),
    modality VARCHAR(20),
    content TEXT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Telegram events table
CREATE TABLE telegram_events (
    id SERIAL PRIMARY KEY,
    channel VARCHAR(50),
    modality VARCHAR(20),
    content TEXT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Conversation logs table
CREATE TABLE conversation_logs (
    id SERIAL PRIMARY KEY,
    conversation_id VARCHAR(255),
    request JSONB,
    response JSONB,
    tool_calls JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Outbound logs table
CREATE TABLE outbound_logs (
    id SERIAL PRIMARY KEY,
    channel VARCHAR(50),
    modality VARCHAR(20),
    content TEXT,
    metadata JSONB,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Error logs table
CREATE TABLE ai_assistant_errors (
    id SERIAL PRIMARY KEY,
    workflow VARCHAR(255),
    step VARCHAR(255),
    error_type VARCHAR(255),
    error_message TEXT,
    timestamp TIMESTAMP,
    execution_id VARCHAR(255),
    full_error JSONB
);

-- Create indexes for better performance
CREATE INDEX idx_discord_events_created ON discord_events(created_at);
CREATE INDEX idx_conversation_logs_conversation_id ON conversation_logs(conversation_id);
CREATE INDEX idx_errors_timestamp ON ai_assistant_errors(timestamp);
```

## Deployment Steps

1. **Import Workflows**
   - Import each JSON file into n8n
   - Ensure all workflows are imported before activating

2. **Configure Credentials**
   - Create all required credentials as listed above
   - Test each credential to ensure connectivity

3. **Setup Webhooks**
   - Configure Twilio webhook to point to: `https://your-n8n-instance.com/webhook/sms-webhook`
   - Configure Telegram webhook via BotFather
   - Discord webhooks are handled automatically by the bot

4. **Activate Workflows**
   - Start with error_handler and health_check
   - Then activate channel ingest workflows
   - Finally activate primary_ai and outbound_dispatcher

5. **Test Each Channel**
   - Send test message via Discord DM
   - Send test SMS
   - Send test Telegram message
   - Test voice commands in Discord

## Error Handling

The system includes comprehensive error handling:

1. **Automatic Error Capture**: All workflow errors are caught by the error_handler workflow
2. **Discord Notifications**: Errors are posted to Discord channel `1374302440324599808`
3. **SMS Alerts**: Critical errors (rate limits, quota exceeded) trigger SMS alerts
4. **Database Logging**: All errors are logged to PostgreSQL for analysis

## Monitoring

- **Health Check**: GET request to `/health` returns system status
- **Logs**: Check PostgreSQL tables for conversation and error logs
- **Metrics**: Monitor execution times and success rates in n8n

## Voice Recording Management

- Voice recordings are stored only when `/record` command is active
- Recordings are automatically deleted after 7 days
- Only Gavin's voice commands are processed (Discord ID: 212103531446927362)

## Security Considerations

1. **User Filtering**: Only processes messages from authorized users
2. **PII Redaction**: Implement PII redaction in logs if needed
3. **Credential Security**: Use n8n's built-in credential encryption
4. **Network Security**: Use HTTPS for all webhooks
5. **Database Security**: Use strong passwords and restrict access

## Troubleshooting

### Common Issues

1. **Bot Not Responding**
   - Check workflow activation status
   - Verify credentials are valid
   - Check error_handler workflow for logged errors

2. **Voice Commands Not Working**
   - Ensure Discord bot has voice permissions
   - Check Whisper API quota
   - Verify audio file downloads are working

3. **Tool Execution Failures**
   - Verify OAuth tokens are not expired
   - Check API rate limits
   - Ensure proper scopes for Google services

### Debug Mode

Enable verbose logging in n8n:
```bash
export N8N_LOG_LEVEL=debug
```

## Maintenance

### Daily Tasks
- Monitor error logs in Discord error channel
- Check health endpoint

### Weekly Tasks
- Review conversation logs for quality
- Check API usage and quotas
- Clean up old voice recordings

### Monthly Tasks
- Rotate API keys if needed
- Review and optimize workflow performance
- Update tool permissions as needed

## Support

For issues or questions:
1. Check error logs in Discord channel `1374302440324599808`
2. Review PostgreSQL error logs
3. Check n8n execution history