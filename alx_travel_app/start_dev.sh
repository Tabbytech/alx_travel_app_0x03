#!/bin/bash

# ALX Travel App Development Startup Script
# This script starts all necessary services for development

echo "Starting ALX Travel App Development Environment..."
echo "=================================================="

# Check if we're in the right directory
if [ ! -f "manage.py" ]; then
    echo "Error: Please run this script from the alx_travel_app directory"
    exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if RabbitMQ is running
check_rabbitmq() {
    if command_exists rabbitmqctl; then
        if rabbitmqctl status >/dev/null 2>&1; then
            echo "RabbitMQ is running"
            return 0
        else
            echo " RabbitMQ is not running. Starting..."
            if command_exists systemctl; then
                sudo systemctl start rabbitmq-server
            elif command_exists brew; then
                brew services start rabbitmq
            else
                echo "Please start RabbitMQ manually"
                return 1
            fi
        fi
    else
        echo "RabbitMQ is not installed. Please install it first."
        echo "   Ubuntu/Debian: sudo apt install rabbitmq-server"
        echo "   macOS: brew install rabbitmq"
        return 1
    fi
}

# Check if Python dependencies are installed
check_dependencies() {
    if [ ! -d "venv" ] && [ ! -d ".venv" ]; then
        echo "Installing Python dependencies..."
        pip install -r requirements.txt
    else
        echo "Python dependencies are installed"
    fi
}

# Start Django development server
start_django() {
    echo "Starting Django development server..."
    python manage.py runserver &
    DJANGO_PID=$!
    echo "   Django server started with PID: $DJANGO_PID"
}

# Start Celery worker
start_celery() {
    echo " Starting Celery worker..."
    celery -A alx_travel_app worker --loglevel=info &
    CELERY_PID=$!
    echo "   Celery worker started with PID: $CELERY_PID"
}

# Start Celery beat (optional)
start_celery_beat() {
    echo " Starting Celery beat scheduler..."
    celery -A alx_travel_app beat --loglevel=info &
    BEAT_PID=$!
    echo "   Celery beat started with PID: $BEAT_PID"
}

# Main execution
main() {
    echo "Checking prerequisites..."
    
    # Check dependencies
    check_dependencies
    
    # Check RabbitMQ
    if ! check_rabbitmq; then
        echo " Cannot proceed without RabbitMQ"
        exit 1
    fi
    
    echo ""
    echo " Starting services..."
    
    # Start Django
    start_django
    
    # Wait a moment for Django to start
    sleep 3
    
    # Start Celery
    start_celery
    
    # Wait a moment for Celery to start
    sleep 2
    
    # Start Celery beat
    start_celery_beat
    
    echo ""
    echo " All services started successfully!"
    echo "=================================================="
    echo "Django Server: http://localhost:8000"
    echo "API Docs: http://localhost:8000/swagger/"
    echo "Celery Worker: Running in background"
    echo "Celery Beat: Running in background"
    echo ""
    echo "To stop all services, run: pkill -f 'python manage.py runserver' && pkill -f 'celery'"
    echo ""
    echo " Test Celery setup: python test_celery_setup.py"
    echo "Test email task: python manage.py test_celery <booking_id>"
    
    # Wait for user input to stop
    echo ""
    read -p "Press Enter to stop all services..."
    
    # Cleanup
    echo "Stopping all services..."
    pkill -f "python manage.py runserver"
    pkill -f "celery"
    echo "All services stopped"
}

# Run main function
main
