/*
 * Some objects' position return with 'getPos' command have their 3D model shifted to some other place. This method
 * can return the real position of the 3D model (object visible to the player) using the distance to the real center
 * and orientation to the real center.
 *
 * Arguments:
 * 0: orientation of the object (float)
 * 1: ATL position (Position)
 * 2: correction to apply on the orientation of the object (float)
 * 3: distance to apply on the distance of the object (float)
 *
 * Return values:
 * Corrected position (Position).
 */

params ["_orientation", "_posATL", "_correctionOrientation", "_correctionDistance"];

private _orientationToRealTreeDegrees = ((((_orientation + _correctionOrientation) % 360) + 180) % 360);

private _currentX = _posATL select 0;
private _currentY = _posATL select 1;
private _currentZ = _posATL select 2;

private _deltaNorth = (cos _orientationToRealTreeDegrees) * _correctionDistance;
private _deltaEast = (sin _orientationToRealTreeDegrees) * _correctionDistance;

private _correctedX = _currentX + _deltaEast;
private _correctedY = _currentY + _deltaNorth;
private _correctedPos = [_correctedX, _correctedY, _currentZ];

_correctedPos;