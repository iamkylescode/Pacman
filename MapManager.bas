Attribute VB_Name = "MapManager"
'@Folder "PacManEngine.Model.Maps"
Option Explicit

Private mMaze() As Tile


Public Property Get Maze() As Tile()
    Maze = mMaze
End Property
Public Property Let Maze(value() As Tile)
    mMaze = value
End Property

Public Property Get RowCount() As Long
    RowCount = (UBound(mMaze, 1) - LBound(mMaze, 1))
End Property

Public Property Get ColCount() As Long
    ColCount = (UBound(mMaze, 2) - LBound(mMaze, 2))
End Property
Public Function GetMazeTile(row As Integer, col As Integer) As Tile
    Set GetMazeTile = mMaze(CyclicRow(row), CyclicCol(col))
End Function

Public Function GetNextTile(CurrentTile As Tile, Heading As Direction, Optional lookAhead As Integer = 1) As Tile
        Select Case Heading
        Case Direction.dDown
            If CurrentTile.y = UBound(mMaze, 1) Then
            '//wrap around
                Set GetNextTile = mMaze(LBound(mMaze, 1) + lookAhead - 1, CurrentTile.x)
            Else
                Set GetNextTile = mMaze(CurrentTile.y + lookAhead, CurrentTile.x)
            End If
            
        Case Direction.dLeft
            If CurrentTile.x = LBound(mMaze, 2) Then
            '//wrap around
                Set GetNextTile = mMaze(CurrentTile.y, UBound(mMaze, 2) - lookAhead + 1)
            Else
                Set GetNextTile = mMaze(CurrentTile.y, CurrentTile.x - lookAhead)
            End If
            
        Case Direction.dRight
            If CurrentTile.x = UBound(mMaze, 2) Then
            '//wrap around
                Set GetNextTile = mMaze(CurrentTile.y, LBound(mMaze, 2) + lookAhead - 1)
            Else
                Set GetNextTile = mMaze(CurrentTile.y, CurrentTile.x + lookAhead)
            End If
            
        Case Direction.dUp
            If CurrentTile.y = LBound(mMaze, 1) Then
            '//wrap around
                Set GetNextTile = mMaze(UBound(mMaze, 1) - (lookAhead + 1), CurrentTile.x)
            Else
                Set GetNextTile = mMaze(CurrentTile.y - lookAhead, CurrentTile.x)
            End If
    End Select
End Function

Public Function TileDistance(targetedTile As Tile, optionTile As Tile) As Long
    '// a^2 +b^2 = c^2

    TileDistance = Sqr((targetedTile.y - optionTile.y) ^ 2 + (targetedTile.x - optionTile.x) ^ 2)

End Function

Private Function CyclicRow(row As Integer) As Integer
    
    If row <= UBound(mMaze, 1) And row >= LBound(mMaze, 1) Then
        CyclicRow = row
    ElseIf row > UBound(mMaze, 1) Then
        CyclicRow = CyclicRow(row - RowCount)
    ElseIf row < LBound(mMaze, 1) Then
        CyclicRow = CyclicRow(row + RowCount)
    End If
    
End Function

Private Function CyclicCol(col As Integer) As Integer
    If col <= UBound(mMaze, 2) And col >= LBound(mMaze, 2) Then
        CyclicCol = col
    ElseIf col > UBound(mMaze, 2) Then
        CyclicCol = CyclicCol(col - ColCount)
    ElseIf col < LBound(mMaze, 2) Then
        CyclicCol = CyclicCol(col + ColCount)
    End If
End Function


