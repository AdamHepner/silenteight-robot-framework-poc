FROM robotframework/rfdocker:3.0.4

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH src/
COPY src/ src/