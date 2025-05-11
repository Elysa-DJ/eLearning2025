import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps * 2 - 1, (index) {
        // Even indices are the circle steps, odd indices are connectors
        if (index % 2 == 0) {
          final stepIndex = index ~/ 2;
          return _buildStepCircle(stepIndex);
        } else {
          final connectorIndex = index ~/ 2;
          return _buildConnector(connectorIndex);
        }
      }),
    );
  }

  Widget _buildStepCircle(int step) {
    final isActive = step <= currentStep;
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue : Colors.grey[300],
      ),
      child: Center(
        child: Text(
          "${step + 1}",
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildConnector(int index) {
    final isActive = index < currentStep;
    return Container(
      width: 30,
      height: 2,
      color: isActive ? Colors.blue : Colors.grey[300],
    );
  }
}