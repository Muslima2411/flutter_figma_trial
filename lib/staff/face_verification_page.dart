import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class FaceVerificationPage extends StatefulWidget {
  const FaceVerificationPage({super.key});

  @override
  State<FaceVerificationPage> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationPage> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isVerifying = false;
  String _statusMessage = 'Position your face in the frame';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(frontCamera, ResolutionPreset.medium);

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Camera error: ${e.toString()}';
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Verification'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Camera preview section
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: _buildCameraPreview(),
              ),
            ),
          ),

          // Status section
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isVerifying ? Icons.security : Icons.info_outline,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _statusMessage,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Verify button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isInitialized && !_isVerifying
                        ? _verifyFace
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isVerifying
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Verifying...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'Verify Face',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (!_isInitialized || _controller == null) {
      return Container(
        color: Colors.grey[900],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Initializing Camera...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        CameraPreview(_controller!),
        // Face guide overlay
        Center(
          child: Container(
            width: 220,
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                color: _isVerifying ? Colors.blue : Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _verifyFace() async {
    if (_controller == null || !_isInitialized) return;

    setState(() {
      _isVerifying = true;
      _statusMessage = 'Verifying your identity...';
    });

    try {
      // Simulate face verification process
      await Future.delayed(const Duration(seconds: 3));

      // Mock verification result (replace with actual face recognition logic)
      final isVerified = DateTime.now().millisecond % 2 == 0; // Random for demo

      if (mounted) {
        setState(() {
          _isVerifying = false;
          _statusMessage = isVerified
              ? 'Verification successful!'
              : 'Verification failed';
        });

        _showResultDialog(isVerified);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _statusMessage = 'Verification error occurred';
        });
      }
    }
  }

  void _showResultDialog(bool isVerified) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(
                isVerified ? Icons.check_circle : Icons.error,
                color: isVerified ? Colors.green : Colors.red,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                isVerified ? 'Success' : 'Failed',
                style: TextStyle(
                  color: isVerified ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            isVerified
                ? 'Face verification successful! You can now proceed.'
                : 'Face verification failed. Please try again.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            if (!isVerified)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Try Again'),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                if (isVerified) {
                  Navigator.of(context).pop(); // Go back to previous screen
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isVerified ? Colors.green : Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: Text(isVerified ? 'Continue' : 'Cancel'),
            ),
          ],
        );
      },
    );
  }
}
