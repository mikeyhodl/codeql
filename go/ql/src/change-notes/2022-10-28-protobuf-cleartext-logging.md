---
category: minorAnalysis
---
* Query `go/clear-text-logging` now excludes `GetX` methods of protobuf `Message` structs, except where taint is specifically known to belong to the right field. This is to avoid FPs where taint is written to one field and then spuriously read from another.
