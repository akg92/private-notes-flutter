// File class for the location management

class FileModel {

  String _fileLocation;
  FileType _fileType; // file type

  FileModel(this._fileLocation, {fileType = FileType.LOCAL}){
    this._fileType = fileType;
  }

  String get fileLocation => _fileLocation;

  FileType get fileType => _fileType;


}
// File Type enum
enum FileType {
  LOCAL,
  REMOTE,
  DB
}