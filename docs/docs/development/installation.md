# Installation Guide

This guide will help you set up the NDF Studio backend for development.

## Prerequisites

- **Python 3.8+**: The backend requires Python 3.8 or higher
- **Git**: For cloning the repository
- **Virtual Environment**: Recommended for Python dependency management

## Step-by-Step Installation

### 1. Clone the Repository

```bash
git clone https://github.com/gnowledge/nodeBook.git
cd nodeBook
```

### 2. Set Up Python Virtual Environment

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Linux/macOS:
source venv/bin/activate
# On Windows:
venv\Scripts\activate
```

### 3. Install Dependencies

```bash
# Install Python dependencies
pip install -r backend/requirements.txt

# Install spaCy model (required for CNL parsing)
python -m spacy download en_core_web_sm
```

### 4. Set Up Environment Variables

Create a `.env` file in the project root:

```bash
# Backend configuration
BACKEND_HOST=localhost
BACKEND_PORT=8000
DEBUG=True

# Database configuration
DATABASE_URL=sqlite:///./ndf_studio.db

# JWT configuration
JWT_SECRET_KEY=your-secret-key-here
JWT_ALGORITHM=HS256
JWT_ACCESS_TOKEN_EXPIRE_MINUTES=30

# spaCy model
SPACY_MODEL=en_core_web_sm
```

### 5. Initialize the Database

```bash
# Run database migrations (if using Alembic)
# alembic upgrade head

# Or create initial database
python -c "from backend.core.models import *; from backend.config import get_data_root; print('Database initialized')"
```

### 6. Create Admin User

```bash
# Run the post-install script to create admin user
python scripts/post_install.py
```

## Running the Application

### Development Server

```bash
# Start the backend server
bash scripts/start_backend.sh

# Or manually
cd backend
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Production Server

```bash
# For production deployment
cd backend
uvicorn main:app --host 0.0.0.0 --port 8000
```

## Verification

Once the server is running, you can verify the installation:

1. **Health Check**: Visit `http://localhost:8000/api/health`
2. **API Documentation**: Visit `http://localhost:8000/docs`
3. **Alternative Docs**: Visit `http://localhost:8000/redoc`

## Troubleshooting

### Common Issues

#### Import Errors
If you encounter import errors, ensure you're in the correct directory and the virtual environment is activated:

```bash
# Make sure you're in the project root
pwd  # Should show /path/to/nodeBook

# Activate virtual environment
source venv/bin/activate

# Check Python path
python -c "import sys; print('\n'.join(sys.path))"
```

#### spaCy Model Issues
If spaCy model is not found:

```bash
# Reinstall spaCy model
python -m spacy download en_core_web_sm

# Verify installation
python -c "import spacy; nlp = spacy.load('en_core_web_sm'); print('spaCy model loaded successfully')"
```

#### Port Already in Use
If port 8000 is already in use:

```bash
# Find process using port 8000
lsof -i :8000

# Kill the process
kill -9 <PID>

# Or use a different port
uvicorn main:app --reload --host 0.0.0.0 --port 8001
```

## Next Steps

After successful installation:

1. Check the [API Reference](../api/core/models.md) for available endpoints
2. Run tests with `bash run_tests.sh`
3. Explore the codebase in the `backend/` directory 